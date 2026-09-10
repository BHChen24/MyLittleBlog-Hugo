---
title: "JVM in short"
date: 2026-09-10T11:22:00
description: "Super Simplified JVM Notes"
tags: ["java"]
categories: ["Tech notes"]
---

## What is the JVM?

1. Java programs need the JVM to run.
2. Like .NET Framework.
3. Stands for **Java Virtual Machine**. Java can run on multiple platforms because JVMs are implemented for different systems. So, Java programs can run on any platform that has a JVM (Though JVM may be different).
4. It executes bytecode, which is translated from Java code.
5. Oh, and Kotlin code can also be compiled into bytecode.

## What are JRE, JDK, and JAR?

1. **JRE** (Java Runtime Environment) – It's what Java needs to run, includes the JVM.
2. **JDK** (Java Development Kit) – The toolkit for Java developers (You need it to do developing things), and it includes the JRE. It also contains the `javac` compiler, which turns your code into bytecode.
3. **JAR** (Java ARchive) – A zip file specifically for Java programs. If everything’s set up correctly, you can run it directly.

## What is the JVM made of?

1. **Class Loader Subsystem** – Finds your classes.
2. **Runtime Data Area** – Contains the native method stack, Java method stack, method area, PC Registers, and heap.
    1. Native Method Stack – For calling code in other languages (mainly C++).
    2. Java Method Stack – For storing Java function call stacks.
    3. PC Registers – Tells the interpreter where to go next. Fact: It’s the only area that won’t throw an **OutOfMemoryError**.
    4. Method Area – Holds class-related info. It’s shared between threads.
    5. Heap – Just the heap, shared between threads.
    6. Anything not explicitly mentioned is thread-private.
3. **Execution Engine** – Interpreter, JIT (Just-In-Time compiler), and GC (Garbage Collector).
4. **Native Method Library**.

## Class Loader Subsystem?

1. **MyClass.java** -> Loading (find the class) -> Linking -> Verify, Prepare, Resolve -> Initialization.
    1. **Verify** – Did you write your class correctly?
    2. **Prepare** – Allocates memory for `static` variables and sets them to default.
    3. **Resolve** – Turns symbolic references (names) into direct references (addresses).

## Loading: Class Loaders

Everything’s an object in Java, even the classes themselves are loaded by class loader objects.

1. **BootStrapClassLoader** – The default loader, it looks in the `jre/Lib` directory.
2. **ExtClassLoader** – Inherits from `BootStrapClassLoader` and `ClassLoader`, looks in `jre/Lib/ext`.
3. **AppClassLoader** – Inherits from `ExtClassLoader` and `ClassLoader`, looks in the working directory.
    - Thanks to the delegation, it will always check the parent loader first, preventing duplicate class loads. If the parent finds a class, it won’t look further.
    - Can specify the classpath using `classpath` in the command line.
    - **Tomcat** has its own class loader, which extends `ClassLoader`.

## Method Area?

Holds the constant pool, method info, and class info.

## Java Method Stack (JVM Language Stack)?

It has a **local variable table**, **operand stack**, **dynamic linking**, and **method return addresses**. The native method stack is similar but handles methods from other languages.

- **Local Variable Table** – Stores variable names and values.
- **Operand Stack** – Fetches variables from the local variable table for computation. The value is removed from the variable table when it's being computed.

## Heap?

- Objects live here. Generally, it’s about `physical memory / 64` in size, maxing out at `physical memory / 4`.
- It’s divided into the **young generation** and the **old generation**, with a default size ratio of 1:2.
- The young generation is further divided into the **eden**, **S1**, and **S2** spaces, with a default ratio of 8:1:1.
- New objects go into the **eden**. When eden fills up, it triggers a **young/minor GC**. Surviving objects are moved to either **S1** or **S2**.
    - During each GC, survivors in S1 or S2 also get checked. Survivors of the survivor spaces “jump” between **S1** and **S2**.
    - If an object survives long enough, it moves to the **old generation**.
    - If an object is too large to fit into eden or S1/S2, it goes directly to the **old generation**.
- The old generation is handled by another GC, like **major GC** or **Full GC**.
    - **Major GC** is mostly and only done by **CMS method (See below)**, while Full GC will clean the old generation along with everything else.

## GC?

### How to Find Garbage?

- **Reference counting** – Track the number of references to an object. But this can’t handle circular references.
- **Reachability analysis** – Defines several **GC roots** and traverses the objects from those roots like a tree. Anything unreachable is considered garbage.
    - Possible GC roots include things like currently running methods, constants, and static variables in the method area.

### How to Reclaim Garbage?

1. **Mark-Sweep** – Marks the garbage and deletes it.
    - This can lead to memory fragmentation, where there’s not enough contiguous space to allocate new objects.
2. **Copy** – Copies live objects elsewhere, then deletes the whole old memory space.
    - This requires a backup memory space of the same size.
    - It moves objects, which can take some time.
3. **Mark-Compact** – Marks the garbage and deletes it, then compacts the remaining live objects.
    - It’s the slowest of the three algorithms.

### How to Do It Better?

Generational collection:

1. Objects with short lifetimes (in the young generation) are best handled by the copy algorithm because you can get rid of a lot of garbage quickly.
2. Long-living objects (in the old generation) generally don't use the copy algorithm and instead rely on other algorithms based on needs.

## Common GC Algorithms

1. **Serial GC** – An old algorithm. It pauses work threads, starts a new thread to perform GC, and uses the mark-sweep and mark-compact algorithms.
2. **ParNew GC** – A multithreaded version of Serial GC.
3. **CMS** (**Concurrent Mark-Sweep Garbage Collector**) – Used for the old generation, it uses the mark-sweep method. It minimizes pauses by using initial marking but requires an extra re-marking step to ensure accuracy. **Most of its work happens in parallel with application threads.** It's now considered outdated.
4. **Parallel GC** – Replaces the Serial algorithm and can dynamically adjust memory allocation. It’s the default in JDK 8.
5. **Newer GCs, mainly Full GC**:
    1. **G1** (Garbage First) – A region-based algorithm that divides memory into 2048 regions. Its strength is that it offers controllable latency. It’s the default in JDK 9. It has final marking and evacuation steps, where most of the time is spent. With the help of initial marking, **the rest of the process happens in parallel with application threads**.
    2. **ZGC** – A complex paging-based algorithm. Its unique feature is short STW (Stop-the-World) times, which don’t increase with heap size.
    3. **For the new generation GC**, the algorithms are not so straightforward, so you might want to dive deeper into that yourself.
