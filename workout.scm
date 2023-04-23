; "Fitness tracking and management" Features:
; ; Workout Tracking
; ; Cardio Tracking
; ; Routine Creation and Management
; ; Body Measurements
; ; Nutrition Tracking
; ; Activity Tracking
; ; Sleep Tracking
; ; Gamification

; Routines are made up of Daily Workouts in a weekly schedule
; Daily Workout contains exercises
; Exercises contain sets, reps, weight, and optional, rest time and notes

(use-modules (srfi srfi-9))

(define-record-type <exercise>
  (make-exercise
   name
   sets
   reps
   intensity-percentage
   rest-time
   notes)
  exercise?
  (name get-name)
  (sets get-sets)
  (reps get-reps)
  (intensity-percentage get-intensity)
  (rest-time get-rest-time)
  (notes get-notes))

(define-record-type <daily-workout>
  (make-daily-workout
   name
   exercises)
  daily-workout?
  (name daily-workout-name)
  (exercises daily-workout-exercises))

(define-record-type <routine>
  (make-routine
   name
   daily-workouts)
  routine?
  (name routine-name)
  (daily-workouts routine-daily-workouts))

; Example PUSH/PULL/LEGS routine
(define push-pull-legs-routine
  (make-routine
   "Push/Pull/Legs"
   (list
    (make-daily-workout
     "Legs (Quads and Calves Focus)"
     (list
      (make-exercise "Barbell Back Squats" 4 8 0 60 "8-10 reps")
      (make-exercise "Leg Press" 4 10 0 60 "10-12 reps")
      (make-exercise "Walking Lunges" 3 12 0 60 "12 reps per leg")
      (make-exercise "Leg Extensions" 3 12 0 60 "12-15 reps")
      (make-exercise "Standing Calf Raises" 4 12 0 60 "12-15 reps")
      (make-exercise "Seated Calf Raises" 4 12 0 60 "12-15 reps")))
    (make-daily-workout
     "Pull (Back and Biceps Focus)"
     (list
      (make-exercise "Pull-ups or Assisted Pull-ups" 4 8 0 60 "8-10 reps")
      (make-exercise "Barbell Bent Over Rows" 4 8 0 60 "8-10 reps")
      (make-exercise "Seated Cable Rows" 4 10 0 60 "10-12 reps")
      (make-exercise "Lat Pulldowns" 3 10 0 60 "10-12 reps")
      (make-exercise "Barbell Bicep Curls" 3 10 0 60 "10-12 reps")
      (make-exercise "Hammer Curls" 3 10 0 60 "10-12 reps")))
    (make-daily-workout
     "Push (Chest, Shoulders, and Triceps Focus)"
     (list
      (make-exercise "Barbell Bench Press" 4 8 0 60 "8-10 reps")
      (make-exercise "Incline Dumbbell Press" 4 8 0 60 "8-10 reps")
      (make-exercise "Dumbbell Shoulder Press" 4 10 0 60 "10-12 reps")
      (make-exercise "Lateral Raises" 3 12 0 60 "12-15 reps")
      (make-exercise "Skull Crushers" 3 10 0 60 "10-12 reps")
      (make-exercise "Tricep Pushdowns" 3 10 0 60 "10-12 reps")))
    (make-daily-workout
     "Legs (Hamstrings and Glutes Focus)"
     (list
      (make-exercise "Deadlift" 4 6 0 60 "6-8 reps")
      (make-exercise "Romanian Deadlift" 4 8 0 60 "8-10 reps")
      (make-exercise "Bulgarian Split Squats" 3 10 0 60 "10-12 reps per leg")
      (make-exercise "Lying Leg Curls" 3 12 0 60 "12-15 reps")
      (make-exercise "Hip Thrusts" 3 12 0 60 "12-15 reps")
      (make-exercise "Glute Kickbacks" 3 12 0 60 "12-15 reps")))
    (make-daily-workout
     "Pull (Back and Biceps Focus, Variation)"
     (list
      (make-exercise "Chin-ups or Assisted Chin-ups" 4 8 0 60 "8-10 reps")
      (make-exercise "T-Bar Rows" 4 8 0 60 "8-10 reps")
      (make-exercise "Single-arm Dumbbell Rows" 4 10 0 60 "10-12 reps")
      (make-exercise "Straight Arm Pulldowns" 3 12 0 60 "12-15 reps")
      (make-exercise "Incline Dumbbell Bicep Curls" 3 10 0 60 "10-12 reps")
      (make-exercise "Concentration Curls" 3 10 0 60 "10-12 reps")))
    (make-daily-workout
     "Push (Chest, Shoulders, and Triceps Focus, Variation)"
     (list
      (make-exercise "Dumbbell Bench Press" 4 8 0 60 "8-10 reps")
      (make-exercise "Cable Chest Fly" 4 10 0 60 "10-12 reps")
      (make-exercise "Seated Military Press" 4 8 0 60 "8-10 reps")
      (make-exercise "Face Pulls" 3 12 0 60 "12-15 reps")
      (make-exercise "Close Grip Bench Press" 3 10 0 60 "10-12 reps")
      (make-exercise "Overhead Tricep Extension" 3 10 0 60 "10-12 reps")))
    (make-daily-workout
     "Rest"
     (list)))))

; FORMAT BEGINS HERE
; In org-mode format for easy import into Emacs org-mode files for tracking progress over time
(define (format-exercise-record exercise)
  (string-append
   "*** "(get-name exercise) "\n"
   "- Sets: " (number->string (get-sets exercise)) "\n"
   "- Reps: " (number->string (get-reps exercise)) "\n"
   "- Intensity: " (number->string (get-intensity exercise)) "\n"
   "- Rest Time: " (number->string (get-rest-time exercise)) "\n"
   "- Notes: "(get-notes exercise)))

(define (format-daily-workout-record daily-workout)
  (string-append
   "** "(daily-workout-name daily-workout) "\n"
   (string-join (map format-exercise-record (daily-workout-exercises daily-workout)) "\n")))

(define (format-routine-record routine)
  (string-append
   "* " (routine-name routine) "\n"
   (string-join (map format-daily-workout-record (routine-daily-workouts routine)) "\n")))
; FORMAT ENDS HERE

; Print routines to file
(define (to-file record file)
  (call-with-output-file file
    (lambda (port)
      (display record port))))

; Print routines to REPL
(define (to-repl record)
  (display record))

; Print routine to file
(define (print-routine-to-file routine file)
  (to-file (format-routine-record routine) file))

; Print routine to REPL
(define (print-routine-to-repl routine)
  (to-repl (format-routine-record routine)))

; Genric print for both file and REPL
(define (print-routine routine file)
  (cond 
    ((not (null? file)) (print-routine-to-file routine file))
    (else (print-routine-to-repl routine))))


(define-record-type <body-measurement>
  (make-body-measurement
   date
   weight
   notes)
  body-measurement?
  (date body-measurement-date)
  (weight body-measurement-weight)
  (notes body-measurement-notes))

(define example-body-measurement
  (make-body-measurement "2019-01-01" 200 "No notes"))

(define-record-type <cardio-workout>
  (make-cardio-workout
   date
   duration
   distance
   notes)
  cardio-workout?
  (date cardio-workout-date)
  (duration cardio-workout-duration)
  (distance cardio-workout-distance)
  (notes cardio-workout-notes))

(define example-cardio-workout
  (make-cardio-workout "2019-01-01" 60 5 "No notes"))

(define-record-type <sleep-record>
  (make-sleep-record
   date
   duration
   notes)
  sleep-record?
  (date sleep-record-date)
  (duration sleep-record-duration)
  (notes sleep-record-notes))

(define example-sleep-record
  (make-sleep-record "2019-01-01" 480 "No notes"))

