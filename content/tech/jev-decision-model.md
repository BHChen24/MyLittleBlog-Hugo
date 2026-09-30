---
title: "Jev: A Fast Decision Layer for AI Apps?"
date: 2026-09-29T12:00:00-04:00
description: "What TypeSafe's Jev does and where I think it fits"
tags: ["ai", "tools", "opinion"]
categories: ["Tech notes"]
draft: false
---

A support app can spend an entire LLM call answering a small question: "Which team should handle this message?" Sometimes all the app needs is a category or an urgency check. A long answer can add detail the app never asked for, and some of it may be wrong.

That's why Jev caught my attention. TypeSafe [released it in early access on September 15, 2026](https://typesafe.ai/blog/introducing-system-one-models-and-jev). It calls Jev a “System One” model. You give it text or structured state and define the answers it may return. Your code gets a decision and probabilities back. Jev doesn't write the reply to the customer or chat with them. And it's impressively fast.

This [Fireship video](https://www.youtube.com/watch?v=TbkUKCm3CHQ) explains the idea in about five minutes:

{{< youtube TbkUKCm3CHQ >}}

## A place for Jev in an app

If I were building a support inbox, I'd have Jev sort messages as they arrive. For example, a customer might write, “I was charged twice and need this fixed today.” Jev could identify it as a billing issue, estimate its urgency, and return probabilities for both judgments. The app could then check the transaction and decide whether to ask an LLM to draft a reply or send the case to a person.

![Diagram showing a message going to Jev, then application code routing it to a lookup, an LLM, or a person.](/images/jev-routing.svg)

TypeSafe's [intent routing example](https://docs.typesafe.ai/patterns/intent-routing) shows this pattern. Jev can answer several questions about the same message in one request.

The question types are called Choice, Score, and Noul. Choice selects from options you provide. Score places something on a scale you define. Interestingly, Noul gives the probability of “yes”; a value near 1 means Jev leans toward yes. Choice and Score also include confidence measures. TypeSafe's [guide](https://docs.typesafe.ai/primitives) has examples of each.

TypeSafe [reports](https://typesafe.ai/blog/introducing-system-one-models-and-jev) response times of roughly 70 to 500 ms and large savings in its workflow tests. I haven't used Jev myself yet, so those are TypeSafe's numbers. Speed wouldn't help much if the app routed too many messages incorrectly. TypeSafe also [documents weaknesses](https://docs.typesafe.ai/model-jaggedness/jev-1.13) with arithmetic, date comparisons, long inputs full of irrelevant detail, and adversarial text.

## How much of this is unique?

One of my concerns is whether Jev does something competitors can't copy. [OpenJev](https://github.com/bonsai/openjev) already uses an open model to return typed option probabilities, and [Laya publishes model weights](https://huggingface.co/convaiinnovations/laya) for similar tasks. Those projects make the idea accessible to people who want to run a model themselves. How closely they match Jev's answers across different workloads is still being tested.

Models and tools keep changing. I think TypeSafe will need to give customers a reason to keep choosing Jev: accurate decisions, useful probabilities, and less risk of hallucinated prose when an app only needs a constrained answer. Jev can still make the wrong decision, so that last point isn't a claim that its answers are always reliable.

I can imagine a larger company wanting this kind of capability. [Cursor acquired Supermaven](https://supermaven.com/blog/sunsetting-supermaven) and brought its completion technology into Cursor Tab. TypeSafe says it plans to [keep building](https://typesafe.ai/blog/introducing-system-one-models-and-jev). I'll watch whether developers keep choosing Jev as open alternatives improve, and whether enough of them pay for it to support TypeSafe as an independent company. If Jev proves more valuable inside a larger AI product, a sale could make sense too.

For more background, [TechCrunch spoke with TypeSafe's founder and developers trying Jev](https://techcrunch.com/2026/09/18/a-new-kind-of-ai-model-from-a-chatgpt-inventor-is-thrilling-developers/).
