import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.tsx'
import { Center, MantineProvider } from '@mantine/core'
import '@mantine/core/styles.css';
import './index.css'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <MantineProvider defaultColorScheme='dark'>
      <Center>
      <main>
        <App />
      </main>
      </Center>
    </MantineProvider>
  </StrictMode>,
)
