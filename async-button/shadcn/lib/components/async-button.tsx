import { Button } from "./ui/button";
import { Loader2Icon } from "lucide-react";
import { toast } from "sonner";
import { useAsyncAction } from "./useAsyncAction";

export default function AsyncButton({ 
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
  action: () => Promise<void>, 
  className?: string,
  submitText?: string,
  loadingText?: string,
  tryAgainText?: string,
  successMessage?: string,
  successDescription?: string | null,
  errorMessage?: string,
  errorDescription?: string
  ready?: boolean,
  unreadyText?: string
}) {
  const { run, loading, error } = useAsyncAction(action, {
    onSuccess: () => {
      toast.success(successMessage, {
        description: successDescription,
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