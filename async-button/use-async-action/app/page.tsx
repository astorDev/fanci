"use client";

import AsyncButton from "@/components/async-button";
import { Input } from "@/components/ui/input";
import { useEffect, useState } from "react";


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
  const [ unreadyReason, setUnreadyReason ] = useState("Nothing in the input");
  const [ inputValue, setInputValue ] = useState("");

  useEffect(() => {
    const trimmed = inputValue.trim().toLowerCase();
    if (trimmed === "") setUnreadyReason("Nothing in the input");
    else if (trimmed.includes("ready")) setUnreadyReason("");
    else setUnreadyReason("Input does not contain `ready`");
  }, [inputValue]);

  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
      <main className="flex flex-col gap-[32px] row-start-2 items-center">
        <h1 className="text-xl">Async Button Demo</h1>
        <AsyncButton action={() => saveStub(inputValue)} />
        <h2 className="text-xl">Customized Button:</h2>
        <AsyncButton 
          action={() => saveStub(inputValue)}
          className="rounded-t-lg rounded-b-none"
          submitText="Save & Apply"
          loadingText="Executing..."
          tryAgainText="Save & Apply"
          successMessage="Done!"
          successDescription={(result: string) => `"${result}" has been saved.`}
          errorMessage="Something went wrong"
          errorDescription="An error occurred while communicating with the server."
          ready={unreadyReason === ""}
          unreadyText={unreadyReason}
        />
        <Input placeholder="Smth containing 'ready'" onChange={e => setInputValue(e.target.value)} />
      </main>
    </div>
  );
}
