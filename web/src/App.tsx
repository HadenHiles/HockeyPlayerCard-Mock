import { useState } from "react";
import PlayerCard from "./components/PlayerCard";
import { fraserMinten } from "./data/player";
import type { PlayerData } from "./models/player";

function App() {
  const [player, setPlayer] = useState<PlayerData>(fraserMinten);

  return <PlayerCard playerData={player} onPlayerSelect={setPlayer} />;
}

export default App;
