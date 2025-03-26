∇ GuessingGame
  ⍝ Simple Number Guessing Game in APL

  ⎕IO ← 1              ⍝ Set Index Origin to 1 (important for ?)
  LOWER_BOUND ← 1
  UPPER_BOUND ← 100
  secret ← LOWER_BOUND + ?(UPPER_BOUND - LOWER_BOUND + 1) ⍝ Generate random integer in range
  guesses ← 0            ⍝ Initialize guess counter
  correct ← 0            ⍝ Flag to control loop exit

  ⎕← 'Welcome to the APL Number Guessing Game!'
  ⎕← 'I''ve picked a number between ', (⍕LOWER_BOUND), ' and ', (⍕UPPER_BOUND), '.' ⍝ Note double apostrophe for literal '

  :While correct = 0
      guesses ← guesses + 1
      ⎕← ''             ⍝ Print a blank line for spacing
      ⎕← 'Guess #',(⍕guesses),': Enter your guess:'
      input ← ⍞         ⍝ Read user input as a character string (safer than ⎕)

      ⍝ --- Attempt to convert input to number & validate ---
      guess ← ¯999     ⍝ Default to an unlikely, invalid value
      validInput ← 1   ⍝ Assume valid initially
      :Trap 0          ⍝ Basic error handling: If ⍎ fails, :Else runs
          tmpGuess ← ⍎input ⍝ Execute string to get number (USE WITH CAUTION in real apps)
          :If (tmpGuess ≠ ⌊tmpGuess) ∨ tmpGuess < LOWER_BOUND ∨ tmpGuess > UPPER_BOUND
              ⎕← 'Invalid input: Please enter a whole number between ',(⍕LOWER_BOUND),' and ',(⍕UPPER_BOUND),'.'
              validInput ← 0
          :Else
              guess ← tmpGuess ⍝ Input seems valid, assign it
          :EndIf
      :Else
          ⎕← 'Invalid input: Please enter a number.'
          validInput ← 0
      :EndTrap

      :If validInput = 1 ⍝ Only proceed if input was valid
          :If guess < secret
              ⎕← 'Too low!'
          :ElseIf guess > secret
              ⎕← 'Too high!'
          :Else
              ⎕← '*** Correct! ***'
              ⎕← 'The number was ', (⍕secret),'.'
              ⎕← 'You guessed it in ', (⍕guesses), ' attempts.'
              correct ← 1 ⍝ Set flag to exit loop
          :EndIf
      :Else
         guesses ← guesses - 1 ⍝ Don't count the invalid attempt
      :EndIf
  :EndWhile

  ⎕← 'Game Over. Thanks for playing!'
∇
