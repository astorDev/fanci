import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Textarea } from "./components/ui/textarea"
import { Button } from "./components/ui/button"
import { Input } from "./components/ui/input"
import { Label } from "./components/ui/label"

function App() {
  return (
    <Tabs defaultValue="account" className=""  >
      <TabsList className="w-full">
        <TabsTrigger value="account">Configuration</TabsTrigger>
        <TabsTrigger value="password">Schema</TabsTrigger>
      </TabsList>
      <TabsContent value="account" className="flex flex-col">
        <p className="text-xs text-muted-foreground my-2">
          💡 If you are non-programmer, maybe use the Visual Editor
        </p>
        <Tabs defaultValue="json" className="flex-1">
          <TabsList className="w-full">
            <TabsTrigger value="json">JSON Editor</TabsTrigger>
            <TabsTrigger value="form">Visual Editor</TabsTrigger>
          </TabsList>
          <TabsContent className="flex flex-col" value="json">
            <Textarea 
              className="h-[240px]" 
              placeholder="Enter JSON configuration here"
              value={`{
      "name": "shadcn",
      "description": "A shadcn component"
}`}
            />
            <Button disabled className="mt-4">
              Save
            </Button>
          </TabsContent>
          <TabsContent className="flex flex-col" value="form">
            <div className="py-4 h-[240px]">
            <form >
                <div className="grid w-full max-w-sm items-center gap-3">
                  <Label htmlFor="email">Name</Label>
                  <Input type="text" id="name" placeholder="Name" />

                  <Label htmlFor="email">Description</Label>
                  <Input type="email" id="email" placeholder="Description" />
                </div>
            </form>

            </div>
              <Button disabled className="mt-4">
                Save
              </Button>
          </TabsContent>
        </Tabs>
      </TabsContent>
      <TabsContent value="password">Here should be editor for schema json</TabsContent>
    </Tabs>
  )
}

export default App