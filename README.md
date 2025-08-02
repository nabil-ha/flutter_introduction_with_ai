# AI Sports Prediction App

A Flutter application that predicts athlete fatigue and injury risks using machine learning models.

## Project Structure

```
ai_app/
├── lib/           # Flutter application code
└── BACKEND/       # Python Flask API
```

## Quick Start

### Flutter App

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Backend API

The backend is a Flask API that serves two ML models:
- Injury Risk Prediction
- Fatigue Level Prediction

#### Running Locally

1. Install Python dependencies:
```bash
pip install flask torch joblib
```

2. Run the Flask app:
```bash
python app.py
```

Note: The backend is currently configured to run at `https://fatigue-injury.onrender.com`. If you want to run locally, update the `baseUrl` in `lib/api/prediction_api.dart`.



## API Endpoints

- `/predict-injury` - POST request for injury risk prediction
- `/predict-fatigue` - POST request for fatigue level prediction

## Deployment Note

The Flask backend (`app.py`) is designed to be deployed on a service like Render or Heroku. Make sure the required model files (`injury_model.pth`, `fatigue_model.pth`, and their respective scalers) are included in your deployment.