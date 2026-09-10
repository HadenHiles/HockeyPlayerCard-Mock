import type { PlayerData } from "../models/player";
import StatItem from "./StatItem";
import styles from "./PlayerCard.module.css";

type PlayerStatsProps = {
  playerData: PlayerData;
};

function PlayerStats({ playerData }: PlayerStatsProps) {
  const fullName = `${playerData.firstName} ${playerData.lastName}`;

  return (
    <>
      <div className="relative z-10 flex flex-col gap-8 sm:flex-row sm:items-end sm:justify-between">
        <div className="flex items-center gap-5 text-left">
          <div
            className={`${styles.jerseyNumber} flex h-28 w-24 items-center justify-center sm:h-36 sm:w-32`}
          >
            {playerData.jerseyNumber}
          </div>
          <div>
            <p className={styles.metaLabel}>Season</p>
            <p className={styles.season}>{playerData.season.label}</p>
            <p className={styles.teamPosition}>
              {playerData.team.abbreviation} • {playerData.position}
            </p>
          </div>
        </div>

        <div className={styles.badge}>Center ice</div>
      </div>

      <div
        className={`${styles.stats} relative z-10 mt-10 grid grid-cols-2 divide-x divide-y sm:grid-cols-4 sm:divide-y-0`}
      >
        <StatItem label="Games" value={playerData.season.gamesPlayed} />
        <StatItem label="Goals" value={playerData.season.goals} />
        <StatItem label="Assists" value={playerData.season.assists} />
        <StatItem label="Points" value={playerData.season.points} />
      </div>

      <div
        className={`${styles.footer} relative z-10 mt-7 flex items-center justify-between gap-4`}
      >
        <span>Penalty minutes: {playerData.season.penaltyMinutes}</span>
        <span className={styles.footerName}>{fullName}</span>
      </div>
    </>
  );
}

export default PlayerStats;
