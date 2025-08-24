import { useState } from "react";

export function useAsyncAction(
  action: () => Promise<void>, { 
    onSuccess, 
    onError 
}: { 
    onSuccess?: () => void; 
    onError?: (error: Error) => void; } = {}
) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);
  const [success, setSuccess] = useState(false);

  const run = async () => {
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      await action();
      setSuccess(true);
      if (onSuccess) {
        onSuccess();
      }
    } catch (error) {
      setError(error as Error);
      if (onError) {
        onError(error as Error);
      }
    } finally {
      setLoading(false);
    }
  };

  return { run, loading, error, success };
}
