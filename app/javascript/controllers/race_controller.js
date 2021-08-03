import { Controller } from "stimulus";
import { Interval, intervalToDuration, format } from "date-fns";

export default class extends Controller {
  static targets = [
    "word",
    "wpm",
    "finishForm",
    "progress",
    "racetrack",
    "statsTemplate",
    "stats",
  ];
  static values = {
    effectiveWords: Number,
  };

  initialize() {
    this.wordIndex = 0;
    this.wordsCleared = 0;
    this.mistakes = {};
  }

  connect() {
    this.started = false;
    this.racetrackTarget.focus();
  }

  disconnect() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  progress() {
    return this.wordsCleared / this.effectiveWordsValue;
  }

  updateProgressBar() {
    this.progressTarget.style.width = `${this.progress() * 100}%`;
  }


  initStatsTarget() {
    this.statsTarget.innerHTML = this.statsTemplateTarget.innerHTML
  }

  renderStats() {
    let { time, wpm } = this.computeStats()
    let wpmDisplay = this.statsTarget.querySelector('#wpm')
    let timeDisplay = this.statsTarget.querySelector('#time')

    if (wpmDisplay) {
      wpmDisplay.innerHTML = `${wpm.toFixed(2)} WPM`
    }

    if (timeDisplay) {
      timeDisplay.innerHTML = `<strong>Time:</strong> ${format(
        time,
        "mm:ss"
      )}`;
    }
  }

  currentWord() {
    return this.wordTargets[this.wordIndex];
  }

  computeStats() {
    let time = new Date() - this.startTime;
    let wpm = this.wordsCleared / (time / 60000);
    let mistakes = this.mistakeCount();
    let accuracy = 1 - mistakes / this.wordTargets.length;
    return {
      cleared: this.wordsCleared,
      wpm,
      time,
      mistakes,
      accuracy,
    };
  }

  isLastWord() {
    return this.wordIndex === this.wordTargets.length - 1;
  }

  updateBuffer(event) {
    if (!this.started) {
      this.startRace();
    }
    let newBuffer = event.target.value;
    let currentWordTarget = this.currentWord()
    if (!this.currentWord) {
      return
    }
    let currentWord = currentWordTarget.textContent.trim();
    this.refreshCurrentWordProgress(newBuffer);
    if (newBuffer.endsWith(" ") || this.isLastWord()) {
      if (newBuffer.trim() == currentWord) {
        event.target.value = "";
        this.advanceWord();
      }
    }
  }

  mistakeCount() {
    return Object.keys(this.mistakes).length;
  }

  advanceWord() {
    let currentWord = this.currentWord().textContent.trim();
    let wordValue = Math.ceil(currentWord.length / 5);
    this.wordsCleared += wordValue;
    this.updateProgressBar();

    this.wordIndex++;
    this.refreshStyles();
    if (this.wordIndex >= this.wordTargets.length) {
      this.completeRace();
    }
  }

  startRace() {
      this.started = true;
      this.startTime = new Date();
      event.target.placeholder = "";
      this.interval = setInterval(this.renderStats.bind(this), 500);
      this.initStatsTarget();
  }

  completeRace() {
    let { time, mistakes } = this.computeStats();
    let form = this.finishFormTarget;
    form.elements["race[time]"].value = time;
    form.elements["race[mistakes]"].value = mistakes;
    form.requestSubmit();
  }

  refreshCurrentWordProgress(buffer) {
    let currentWord = this.currentWord();
    let letters = currentWord.querySelectorAll(".letter");
    if (!currentWord.textContent.trim().startsWith(buffer.trim())) {
      this.mistakes[this.wordIndex] = true;
    }
    letters.forEach((letter, index) => {
      let newClasses = ["letter"];
      let bufferChar = buffer.charAt(index);
      if (bufferChar) {
        if (letter.textContent === bufferChar) {
          newClasses.push("cleared");
        } else {
          newClasses.push("mistake");
        }
      }
      letter.className = newClasses.join(" ");
    });
  }

  refreshStyles() {
    this.wordTargets.forEach((element, index) => {
      if (index < this.wordIndex) {
        element.classList.add("cleared");
      }
    });
  }
}
