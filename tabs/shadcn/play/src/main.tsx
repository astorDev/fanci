import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { Card } from './components/ui/card.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Card className='fixed inset-0 m-auto 
      w-[420px] h-[360px] px-4'>
      <App />
    </Card>
  </StrictMode>,
)
