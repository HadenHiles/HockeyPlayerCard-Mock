import type { PlayerData } from "../models/player";
import styles from "./PlayerCard.module.css";
import PlayerHeader from "./PlayerHeader";
import PlayerSearch from "./PlayerSearch";
import PlayerStats from "./PlayerStats";

type PlayerCardProps = {
  playerData: PlayerData;
  onPlayerSelect: (player: PlayerData) => void;
};

function PlayerCard({ playerData, onPlayerSelect }: PlayerCardProps) {
  return (
    <main
      className={`${styles.page} flex min-h-screen flex-col items-center justify-center px-4 py-10 sm:px-8`}
    >
      <PlayerSearch onSelect={onPlayerSelect} />
      <article className={`${styles.card} w-full max-w-3xl`}>
        <PlayerHeader playerData={playerData} />

        <div className={styles.body}>
          <PlayerStats playerData={playerData} />
        </div>
      </article>
    </main>
  );
}

export default PlayerCard;
