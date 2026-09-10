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
            <button
              className="mb-6 rounded-full border border-[#292a2d]/20 px-4 py-2 text-xs font-bold uppercase tracking-[0.18em] text-[#292a2d]/65 transition-colors hover:bg-[#fec307] hover:text-[#292a2d]"
              type="button"
              onClick={onClose}
            >
              Close card
            </button>
            <PlayerStats playerData={playerData} />
          </div>
        </article>
      )}
    </main>
  );
}

export default PlayerCard;
