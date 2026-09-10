import { useEffect, useState } from "react";
import type { PlayerData } from "../models/player";
import styles from "./PlayerSearch.module.css";

type PlayerSearchProps = {
  onSelect: (player: PlayerData) => void;
};

const productionApiUrl = "https://hockey-player-card-api.vercel.app";
const apiBaseUrl = import.meta.env.DEV
  ? (import.meta.env.VITE_API_URL ?? "")
  : productionApiUrl;

function PlayerSearch({ onSelect }: PlayerSearchProps) {
  const [searchTerm, setSearchTerm] = useState("");
  const [suggestions, setSuggestions] = useState<PlayerData[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    const trimmedSearch = searchTerm.trim();

    if (!trimmedSearch) {
      return;
    }

    const abortController = new AbortController();
    const searchPlayers = async () => {
      setIsLoading(true);

      try {
        const response = await fetch(
          `${apiBaseUrl}/api/players?search=${encodeURIComponent(trimmedSearch)}`,
          { signal: abortController.signal },
        );

        if (!response.ok) {
          throw new Error("Player search failed");
        }

        setSuggestions(await response.json());
      } catch (error) {
        if (error instanceof DOMException && error.name === "AbortError") {
          return;
        }

        setSuggestions([]);
      } finally {
        setIsLoading(false);
      }
    };

    const searchDelay = window.setTimeout(searchPlayers, 250);
    return () => {
      window.clearTimeout(searchDelay);
      abortController.abort();
    };
  }, [searchTerm]);

  function selectPlayer(player: PlayerData) {
    setSearchTerm(`${player.firstName} ${player.lastName}`);
    setSuggestions([]);
    onSelect(player);
  }

  const visibleSuggestions = searchTerm.trim() ? suggestions : [];

  return (
    <div className={styles.search}>
      <div className={styles.inputWrap}>
        <span className={styles.icon} aria-hidden="true">
          ⌕
        </span>
        <input
          className={styles.input}
          type="search"
          value={searchTerm}
          placeholder="Search players"
          aria-label="Search players"
          onChange={(event) => setSearchTerm(event.target.value)}
        />
        {isLoading && <span className={styles.meta}>Searching</span>}
      </div>

      {visibleSuggestions.length > 0 && (
        <div className={styles.suggestions} role="listbox">
          {visibleSuggestions.map((player) => (
            <button
              className={styles.suggestion}
              key={player.id}
              type="button"
              role="option"
              onClick={() => selectPlayer(player)}
            >
              <span className={styles.name}>
                {player.firstName} {player.lastName}
              </span>
              <span className={styles.meta}>
                {player.team.abbreviation} · {player.position}
              </span>
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

export default PlayerSearch;
