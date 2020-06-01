# Heart Disease Random Forest Classifier
Random Forest model to classify heart disease using data from the Machine Learning repository of University of California, Irvine.

## Data Source
1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
4. V.A. Medical Center, Long Beach: : Robert Detrano, M.D., Ph.D.
5. Cleveland Clinic Foundation: Robert Detrano, M.D., Ph.D.

## Algorithm Used
Random Forest

## Input Variables
|#	|Variable	|Description																																									|
|1	|age		|age of patient 																																								|
|2	|sex		|0 = female, 1 = male 																																							|
|3	|cp			|chest pain: 1 = typical angina, 2 = atypical angina, 3 = non-anginal pain, 4 = asymptomatic 																					|
|4	|trestbps	|resting blood pressure (in mm Hg) 																																				|
|5	|chol		|serum cholestoral in mg/dl 																																					|
|6	|fbs		|fasting blood sugar if less than 120 mg/dl, 1 = TRUE, 0 = FALSE 																												|
|7	|restecg	|resting electrocardiographic results: 1 = normal, 2 = having ST-T wave abnormality, 3 = showing probable or definite left ventricular hypertrophy								|
|8	|thalach	|maximum heart rate achieved 																																					|
|9	|exang		|exercise induced angina, 1 = yes, 0 = no 																																		|
|10	|oldpeak	|ST depression induced by exercise relative to rest 																				 											|
|11	|slope		|the slope of the peak exercise ST segment: 1 = upsloping, 2 = flat, 3 = downsloping 																							|
|12	|ca			|number of major vessels (0-3) colored by fluoroscopy																															|	
|13	|thal		|thalium heart scan: 3 = normal (no cold spots), 6 = fixed defect (cold spots during rest and exercise), 7 = reversible defect (when cold spots only appear during exercise)	|
|T	|hd         |diagnosis of heart disease: 0 if less than or equal to 50% diameter narrowing, 1 if greater than 50% diameter narrowing														|