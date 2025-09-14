import { Button } from "../components/ui/button";
import { Loader2Icon } from "lucide-react";
import { toast } from "sonner";
import { useAsyncAction } from "use-async-action";

export default function AsyncButton<T>({ 
  action, 
  className,
  submitText = "Save",
  loadingText = "Saving...",
  tryAgainText = "Try Again",
  successMessage = "Saved!",
  successDescription = null,
  errorMessage = "Failed",
  errorDescription = "An error occurred.",
  ready = true,
  unreadyText = "Save",
}: { 
  action: () => Promise<T>, 
  className?: string,
  submitText?: string,
  loadingText?: string,
  tryAgainText?: string,
  successMessage?: string | ((result: T) => string),
  successDescription?: string | null | ((result: T) => string | null),
  errorMessage?: string,
  errorDescription?: string
  ready?: boolean,
  unreadyText?: string
}) {
  const { run, loading, error } = useAsyncAction(action, {
    onSuccess: (result) => {
      const successMessageText = typeof successMessage === 'function' ? successMessage(result) : successMessage;
      const successDescriptionText = typeof successDescription === 'function' ? successDescription(result) : successDescription;

      toast.success(successMessageText, {
        description: successDescriptionText,
      });
    },
    onError: () => {
      toast.error(errorMessage, {
        description: errorDescription,
      });
    }
  });

  return (
    <Button
      onClick={run}
      disabled={loading || !ready}
      className={className}
    >
      {
        !ready ? unreadyText
        : loading ? (<><Loader2Icon className="animate-spin" />{loadingText}</>)
        : error ? tryAgainText 
        : submitText
      }
    </Button>
  );
}