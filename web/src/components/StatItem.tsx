import styles from "./PlayerCard.module.css";

type StatItemProps = {
  label: string;
  value: number;
};

function StatItem({ label, value }: StatItemProps) {
  return (
    <div className="px-3 py-5 text-center sm:px-5 sm:text-left">
      <p className={styles.statValue}>{value}</p>
      <p className={styles.statLabel}>{label}</p>
    </div>
  );
}

export default StatItem;
