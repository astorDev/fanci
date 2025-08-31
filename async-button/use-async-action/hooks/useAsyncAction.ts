import { useState } from "react";

export function useAsyncAction<T>(
  action: () => Promise<T>, { 
    onSuccess, 
    onError 
}: { 
    onSuccess?: (result: T) => void; 
    onError?: (error: Error) => void; 
  } = {
  }
) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);
  const [success, setSuccess] = useState(false);

  const run = async () => {
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      const result = await action();
      setSuccess(true);
      onSuccess?.(result);
    } catch (error) {
      setError(error as Error);
      onError?.(error as Error);
    } finally {
      setLoading(false);
    }
  };

  return { run, loading, error, success };
}
