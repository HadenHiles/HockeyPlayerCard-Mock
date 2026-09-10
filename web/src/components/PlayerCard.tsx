import type { PlayerData } from '../models/player'
import { useState } from 'react'

function PlayerCard({ playerData }: { playerData: PlayerData }) {
  const [player] = useState(playerData)

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

export default PlayerCard