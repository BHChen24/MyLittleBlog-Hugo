#!/usr/bin/env node
// Pushes the per-language record files Hugo writes into public/ up to Algolia.
//
//   ALGOLIA_APP_ID=... ALGOLIA_ADMIN_KEY=... node scripts/algolia-push.mjs
//
// replaceAllObjects builds a temporary index, fills it, then atomically moves it
// onto the live name, so search never observes a half-written index.
import { readFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { algoliasearch } from "algoliasearch";

const APP_ID = process.env.ALGOLIA_APP_ID;
const ADMIN_KEY = process.env.ALGOLIA_ADMIN_KEY;

if (!APP_ID || !ADMIN_KEY) {
  console.error("ALGOLIA_APP_ID and ALGOLIA_ADMIN_KEY must be set.");
  process.exit(1);
}

// Must match languages.<lang>.params.algolia.indexName in hugo.yaml.
const TARGETS = [
  { file: "public/algolia.json", indexName: "blog_en" },
  { file: "public/zh/algolia.json", indexName: "blog_zh" },
];

const client = algoliasearch(APP_ID, ADMIN_KEY);

// Applied to every index so both languages rank and highlight the same way.
const SETTINGS = {
  searchableAttributes: ["title", "unordered(summary)", "unordered(content)", "tags", "categories"],
  attributesForFaceting: ["searchable(tags)", "searchable(categories)", "section"],
  attributesToSnippet: ["content:40"],
  customRanking: ["desc(date)"],
  distinct: false,
};

let failed = false;

for (const { file, indexName } of TARGETS) {
  if (!existsSync(file)) {
    console.warn(`skip ${indexName}: ${file} not found — run \`hugo\` first`);
    continue;
  }

  const objects = JSON.parse(await readFile(file, "utf8"));

  if (objects.length === 0) {
    console.warn(`skip ${indexName}: ${file} has no records (refusing to wipe the index)`);
    continue;
  }

  const oversized = objects.filter((o) => Buffer.byteLength(JSON.stringify(o)) > 10_000);
  if (oversized.length) {
    console.warn(
      `${indexName}: ${oversized.length} record(s) over 10KB, Algolia may reject them: ` +
        oversized.map((o) => o.objectID).join(", ")
    );
  }

  try {
    await client.setSettings({ indexName, indexSettings: SETTINGS });
    await client.replaceAllObjects({ indexName, objects, batchSize: 1000 });
    console.log(`${indexName}: ${objects.length} records pushed`);
  } catch (err) {
    failed = true;
    console.error(`${indexName}: failed — ${err.message}`);
  }
}

process.exit(failed ? 1 : 0);
