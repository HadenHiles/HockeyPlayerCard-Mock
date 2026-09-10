export interface Team {
  name: string;
  abbreviation: string;
  logoUrl?: string;
}

export interface SeasonStats {
  label: string;
  gamesPlayed: number;
  goals: number;
  assists: number;
  points: number;
  penaltyMinutes: number;
}

export interface PlayerData {
  id: number;
  cardNumber: number;
  firstName: string;
  lastName: string;
  imageUrl: string;
  jerseyNumber: number;
  position: string;
  team: Team;
  season: SeasonStats;
}
