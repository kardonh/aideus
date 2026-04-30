import { useEffect } from "react";
import splashBg from "../../assets/splash.png";

interface SplashScreenProps {
  onFinished: () => void;
}

function SplashScreen({ onFinished }: SplashScreenProps): React.JSX.Element {
  useEffect(() => {
    const doneTimer = setTimeout(() => onFinished(), 4000);
    return () => clearTimeout(doneTimer);
  }, [onFinished]);

  return (
    <div className="splash-screen">
      <img className="splash-bg" src={splashBg} alt="" />
      <h1 className="splash-logo splash-logo-text" aria-label="Aideus Agent">
        AIDEUS AGENT
      </h1>
    </div>
  );
}

export default SplashScreen;
