import { useState } from 'react'
import type { PlayerData } from './models/player'
import PlayerCard from './components/PlayerCard'
import './App.css'

function App() {
  const [player] = useState<PlayerData>({
    id: 1,
    firstName: 'Fraser',
    lastName: 'Minten',
    season: {
      label: '2024-25',
      gamesPlayed: 0,
      goals: 0,
      assists: 0,
      points: 0,
      penaltyMinutes: 0,
    },
    position: 'Center',
    team: { name: 'Hockey Club', abbreviation: 'HC' },
    jerseyNumber: 17,
  })

  return (
    PlayerCard({playerData: player})
  )
}

export default App
