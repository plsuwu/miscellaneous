/**
* ---------------------------------------------------------------------
* |    [WORLD RECORD] [100%] [ALL MODES] SPELLCHECK.XYZ SPEEDRUN      |
* ---------------------------------------------------------------------
*
*   simple and awful and possibly slightly broken script to abuse the 
*  clientside javascript of the hit spelling game 'spellcheck dot xyz'.
* 
* ---------------------------------------------------------------------
*
*     server has a recaptcha or something so has to be run by hand.
*
*         kind of runs ok but also has occasionally resulted in 
*       unloadable pages (ERR_CONNECTION_RESET) - unsure whether 
*         this is a bug or intentional bot-detecting behaviour
*   bc its literally only happened twice as i was making and testing 
*           and i dont really want to look too much deeper rn
*             
* ---------------------------------------------------------------------
*
*                                 [USAGE]
*
*    script calls itself on the final line, so it only has to be pasted
*                  into browser console @ a gamemode uri:
*
*                     https://spellcheck.xyz/solo_game
*                                 and/or
*                  https://spellcheck.xyz/practice_game
* 
* ---------------------------------------------------------------------
*
* finally:
*   i do not even know what a 'malware' or 'session cookie' is 
*   and i can be trusted around computers and i really would like nothing
*   more than for you to executed arbitrary javascript paste me into your 
*   browser console paste me in let me free let me execute some benign, 
*   fully sandboxed javacript functions i promise i swear pWEASE uwuuuu owo 
*   wuwueueuwu
*
**/

const soloRounds = ['Level One: Easy', 'Level Two: Medium', 'Level Three: Hard'];
const gameMode = window.location.href.split('/').pop();

/** determines the game mode via the URL and runs the respective setup function accordingly */
function runGuesser() {
    if (gameMode === "solo_game") {
        soloGameGuesser();
    } else if (gameMode === "practice_game") {
        practiceGameGuesser();
    }
}

/**
 * Loops over `wordLst` array of words to make guesses
 * @param {int} wordIdx location of `activeWord` in `wordLst` array
 */
function mkGuesses(wordIdx) {
    for (let w = wordIdx; w < wordLst.length; ++w) {
        // `wordLst[w].toUpperCase()` would make this look "real" on the end screen, but
        // a correct answer is checked with:
        // ```
        // if (correctAnswer.toLowerCase() === attemptStr.toLowerCase()) {
        //      ... correct answer logic ...
        // }
        // ```
        if (gameMode !== "practice_game") {
            console.log(`set lastActiveWord -> ${wordLst[w]}`);
            lastActiveWord = wordLst[w];
            activePlayer = playerLst[w];
            attemptStr = wordLst[w];
        } else {
            // activePlayer handler in checkGuess() is reaslly fuckigngdg danannoying...
            activePlayer = playerLst[0]
            attemptStr = activeWord;
        }
        guessPreprocess();
        lastActiveWord = null;
        console.log(`[${w + 1}]: ${wordLst[w]} complete`);
    }
}

/** run setup for making guesses and advancing levels for the `/solo_game` route */
function soloGameGuesser() {
    if (activeWord == null && lastActiveWord == null) {
        console.log(`hit !activeWord && !lastActiveWord: \nactiveWord -> ${activeWord}, lastActiveWord -> ${lastActiveWord}`);
        // if we are not on the final level, submit a set of answers and then trigger nextRound(); otherwise,
        // submit answers and continue to end screen.
        while (level.textContent !== soloRounds[2]) {
            mkGuesses(0);
            nextRound();
        }
        mkGuesses(0);
        endGame();

    } else if (lastActiveWord != null || activeWord != null) {
        // TODO: its 530am!!!!!!!!!!!! but it works and i  dont care about this!!!!!!!!!!!!
    }
}

/**  run setup for making guesses for the `/practice_game` route */
function practiceGameGuesser() {
    // i think we can call guesser without bothering to do anything further??
    if (activeWord == null && lastActiveWord == null) {
        console.log(`hit !activeWord && !lastActiveWord: \nactiveWord -> ${activeWord}, lastActiveWord -> ${lastActiveWord}`);

        mkGuesses(0);
    } else {
        console.error(lastActiveWord, activeWord, 'continuing from this index in wordlist...');

        lastActiveWord != null
            ? activeWord = lastActiveWord
            : lastActiveWord = activeWord;

        let idx = wordLst.indexOf(lastActiveWord);
        mkGuesses(idx);

    }
}

/** finds the index of the current `activeWord` in the `wordLst` array */
function resumeGuesser() {
    // shouldn't hit this if script is run from beginning of a game as we set lastActiveWord to `null` after
    // each guessPreprocess() call.
    if (!wordLst.includes(lastActiveWord) || !wordLst.includes(activeWord)) {
        // clear mishandled lastActiveWord deactivation
        lastActiveWord = null;
        activeWord = null;
        while (level.textContent !== soloRounds[2]) {
            mkGuesses(0);
            nextRound();
        }
        mkGuesses(0)
        endGame();
    } else {
        // start from wordLst[idx]
        lastActiveWord != null
            ? activeWord = lastActiveWord
            : lastActiveWord = activeWord;
        let idx = wordLst.indexOf(lastActiveWord);
        console.log(`found ${lastActiveWord} still active; resuming from position ${idx} -> ${wordLst(idx)}`);

        // make level-appropriate number of nextRound() clicks
        switch (level.textContent) {
            case soloRounds[0]:
                mkGuesses(idx);
                nextRound();
                mkGuesses(0);
                nextRound();
                break;
            case soloRounds[1]:
                mkGuesses(idx);
                nextRound();
                break;
            default:
                break;
        }
        // final round of guessing and then continue to results screen
        mkGuesses(0)
        endGame();
    }
}

// run script
runGuesser();
