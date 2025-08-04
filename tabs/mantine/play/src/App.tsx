import { Tabs } from '@mantine/core';

import { IconPhoto, IconMessageCircle, IconSettings } from '@tabler/icons-react';


function App() {
  return (
      <Tabs variant='outline' color='yellow' defaultValue="gallery">
        <Tabs.List>
          <Tabs.Tab value="gallery" leftSection={<IconPhoto size={12} />}>
            Gallery
          </Tabs.Tab>
          <Tabs.Tab value="messages" leftSection={<IconMessageCircle size={12} />}>
            Messages
          </Tabs.Tab>
          <Tabs.Tab value="settings" leftSection={<IconSettings size={12} />}>
            Settings
          </Tabs.Tab>
        </Tabs.List>

        <Tabs.Panel value="gallery">
          Gallery tab
        </Tabs.Panel>

        <Tabs.Panel value="messages">
          Messages tab
        </Tabs.Panel>

        <Tabs.Panel value="settings">
          Settings tab
        </Tabs.Panel>
      </Tabs>
  )
}

export default App
