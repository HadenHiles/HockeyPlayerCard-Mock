export interface PlayerData {
  id: number
  firstName: string
  lastName: string
  jerseyNumber: number
  position: string
  team: {
    name: string
    abbreviation: string
    logoUrl?: string
  }
  season: {
    label: string
    gamesPlayed: number
    goals: number
    assists: number
    points: number
    penaltyMinutes: number
  }
}