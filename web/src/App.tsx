import { useState } from "react";
import PlayerCard from "./components/PlayerCard";
import type { PlayerData } from "./models/player";

function App() {
  const [player, setPlayer] = useState<PlayerData | null>(null);

  return player ? (
    <PlayerCard
      playerData={player}
      onPlayerSelect={setPlayer}
      onClose={() => setPlayer(null)}
    />
  ) : (
    <PlayerCard
      playerData={null}
      onPlayerSelect={setPlayer}
      onClose={() => setPlayer(null)}
    />
  );
}

export default App;
