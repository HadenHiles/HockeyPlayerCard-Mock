import type { PlayerData } from "../models/player";
import styles from "./PlayerCard.module.css";
import PlayerHeader from "./PlayerHeader";
import PlayerSearch from "./PlayerSearch";
import PlayerStats from "./PlayerStats";

type PlayerCardProps = {
  playerData: PlayerData | null;
  onPlayerSelect: (player: PlayerData) => void;
  onClose: () => void;
};

function PlayerCard({ playerData, onPlayerSelect, onClose }: PlayerCardProps) {
  return (
    <main
      className={`${styles.page} flex min-h-screen flex-col items-center justify-center px-4 py-10 sm:px-8`}
    >
      <PlayerSearch
        key={playerData?.id ?? "player-directory"}
        onSelect={onPlayerSelect}
        showPlayerList={!playerData}
      />
      {playerData && (
        <article className={`${styles.card} w-full max-w-3xl`}>
          <PlayerHeader playerData={playerData} />

          <div className={styles.body}>
            <div className={styles.cardToolbar}>
              <button
                className={styles.closeButton}
                type="button"
                onClick={onClose}
              >
                <span aria-hidden="true">×</span>
                Close list
              </button>
            </div>
            <PlayerStats playerData={playerData} />
          </div>
        </article>
      )}
    </main>
  );
}

export default PlayerCard;
