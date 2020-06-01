# Heart Disease Random Forest Classifier
Random Forest model to classify heart disease using data from the Machine Learning [repository](http://archive.ics.uci.edu/ml/machine-learning-databases/ "University of California, Irvine - Machine Learning Databases") of University of California, Irvine.

## Data Source
1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
4. V.A. Medical Center, Long Beach: : Robert Detrano, M.D., Ph.D.
5. Cleveland Clinic Foundation: Robert Detrano, M.D., Ph.D.

## Algorithm Used
`Random Forest`

## Input Variables
|#	|Variable	|Description																																									|
|:-:|:---------:|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|1	|age		|**Age of Patient** 																																							|
|2	|sex		|**Sex**: 0 = Female, 1 = Male 																																					|
|3	|cp			|**Chest Pain**: 1 = Typical Angina, 2 = Atypical Angina, 3 = Non-Anginal Pain, 4 = Asymptomatic 																				|
|4	|trestbps	|**Resting Blood Pressure** (in mm Hg) 																																			|
|5	|chol		|**Serum Cholestoral** (in mg/dl) 																																				|
|6	|fbs		|**Fasting Blood Sugar** if less than 120 mg/dl: 1 = TRUE, 0 = FALSE 																											|
|7	|restecg	|**Resting Electrocardiographic Results**: 1 = Normal, 2 = Hhaving ST-T Wave Abnormality, 3 = Showing probable or definite Left Ventricular Hypertrophy							|
|8	|thalach	|**Maximum Heart Rate** achieved 																																				|
|9	|exang		|Exercise induced **Angina**: 1 = yes, 0 = no 																																	|
|10	|oldpeak	|**ST Depression** induced by exercise relative to rest 																				 										|
|11	|slope		|The slope of the peak exercise ST segment: 1 = Upsloping, 2 = Flat, 3 = Downsloping 																							|
|12	|ca			|Number of Major Vessels (0-3) colored by **Fluoroscopy**																														|	
|13	|thal		|**Thalium Heart Scan**: 3 = Normal (no cold spots), 6 = Fixed Defect (cold spots during rest and exercise), 7 = Reversible Defect (when cold spots only appear during exercise)|
|T	|hd         |Diagnosis of **Heart Disease**: 0 if less than or equal to 50% diameter narrowing, 1 if greater than 50% diameter narrowing														|