import { useState } from 'react'
import type { PlayerData } from './models/player'
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
    <>
      <section id="center">
        <pre>
          {`Name: ${player.firstName} ${player.lastName}
            Position: ${player.position}
            Team: ${player.team.name} (${player.team.abbreviation})
            Jersey Number: ${player.jerseyNumber}
            Season: ${player.season.label}
            Games Played: ${player.season.gamesPlayed}
            Goals: ${player.season.goals}
            Assists: ${player.season.assists}
            Points: ${player.season.points}
            Penalty Minutes: ${player.season.penaltyMinutes}`}
        </pre>
      </section>
    </>
  )
}

export default App
