import type { PlayerData } from "../models/player";
import styles from "./PlayerCard.module.css";

type PlayerHeaderProps = {
  playerData: PlayerData;
};

function PlayerHeader({ playerData }: PlayerHeaderProps) {
  return (
    <header className={styles.header}>
      <div className={styles.logoOrbit} />
      <div className={styles.portraitFrame}>
        <img
          src={playerData.imageUrl}
          alt={`${playerData.firstName} ${playerData.lastName}`}
          className={styles.portrait}
        />
      </div>

      <div className="relative z-2 flex items-start justify-between gap-4">
        <div className="flex items-center gap-3">
          <div
            className={`${styles.brandMark} flex size-12 items-center justify-center`}
          >
            B
          </div>
          <div className="text-left">
            <p className={styles.eyebrow}>{playerData.team.name}</p>
            <p className={styles.profileLabel}>Player profile</p>
          </div>
        </div>
        <p className={styles.cardNumber}>
          #{playerData.cardNumber.toString().padStart(3, "0")}
        </p>
      </div>

      <div className={styles.heroCopy}>
        <p className={styles.position}>The B&apos;s • {playerData.position}</p>
        <h1 className={styles.name}>
          {playerData.firstName}
          <br />
          <span className={styles.nameAccent}>{playerData.lastName}</span>
        </h1>
      </div>
    </header>
  );
}

export default PlayerHeader;
