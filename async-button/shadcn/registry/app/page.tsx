"use client";

import AsyncButton from "@/registry/async-button";

function saveStub(inputValue: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    setTimeout(() => {
      var shouldFail = Math.random() < 0.3;
      if (shouldFail) reject(new Error("Action failed"));
      else resolve(inputValue);
    }, 1000);
  });
}

export default function Home() {
  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        <AsyncButton action={() => saveStub('lol')} />
      </main>
    </div>
  );
}
