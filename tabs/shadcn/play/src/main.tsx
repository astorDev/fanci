import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { Card } from './components/ui/card.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Card className='fixed left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2
      w-[420px] min-h-[360px] px-4'>
      <App />
    </Card>
  </StrictMode>,
)
