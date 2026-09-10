import type { PlayerData } from "../models/player";
import styles from "./PlayerCard.module.css";
import PlayerHeader from "./PlayerHeader";
import PlayerStats from "./PlayerStats";

function PlayerCard({ playerData }: { playerData: PlayerData }) {
  return (
    <main
      className={`${styles.page} flex min-h-screen items-center justify-center px-4 py-10 sm:px-8`}
    >
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
