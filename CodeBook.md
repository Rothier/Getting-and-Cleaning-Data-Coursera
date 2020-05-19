# Introduction

- This data pertains the final assignment of the Getting and Cleaning Data Course Project.
- The dataset provided contained Samsung Galaxy S smartphones' accelerometer and gyroscope measurements while running activity trackers.
- Tests were ran accross 30 subjects, with 6 varying exercise intensities. Each row represents a subject and an intensity
- Measurements are in average triaxial acceleration (for accelerometer measurements) or angular velocity (for gyroscope measurements)

# Process

The script 'run_analysis.R' reads the necessary information provided in the UCI HAR Dataset and assigns. It first aims to recreate the test dataset by creating factors for the varying exercise intensities and naming them in an appropriate manner, as well as adding column names. Afterwards, the data is knit together and a new column is added to later differentiate between test and training to prevent any possible data loss. The same process is then applied to the training dataset. As requested in the assignment, all columns regarding mean or standard deviation values are then identified and a new, complete dataframe is created with these values, as well as subject ID and exercise intensity. The script automatically renames the data for more readable and understandable column names. Finally, the previous dataframe is copied into a final dataframe which groups subjects and intensity of exercise, with the mean of every subject's exercise by its intensity. Finally, the ending dataset is written into a .txt file.

# End result

A 'tidyDataset.txt' file with all the averages of the columns asked for in the assignment grouped by subject and type of exercise.

# Dataset description

- Columns: Column 1 gives the subject ID, column 2 the intensity of the exercise being measured, all columns thereafter (3:81) are the means of time or frequency domain measurements of acceleration or angular velocity across all exercises by that subject.
- Rows: Each row pertains a subject and the intensity of his workout and its corresponding measurements

# Variable names

\$ Subject: Subject ID (30 subjects)

\$ Intensity: Intensity of measured exercise(Walking, walking upstairs, walking downstairs, sitting, standing and laying)

- The measurement variables that come after have a pattern. All values hereafter are an average of the results across multiple sessions.

\$ Time: Time domain signal

\$ Frequency: Frequency domain signal

\$ Body: Measurement of body acceleration

\$ Gravity: Measurement of gravitational acceleration

\$ Mean: Average across exercises

\$ SD: Standard deviation across exercises

\$ Jerk: Measurement of jerk rate

\$ Magnitude: Magnitude of the acceleration vector

\$ Accelerometer: Measured with accelerometer (Triaxil acceleration)

\$ Gyroscope: Measured with gyroscope (Angular velocity)

\$ X: Measured in the X-axis

\$ Y: Measured in the Y-axis

\$ Z: Measured in the Z-axis
