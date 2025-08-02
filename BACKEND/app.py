from flask import Flask, request, jsonify
import torch
import joblib
from torch import nn

app = Flask(__name__)

# Injury Model
injury_model = InjuryClassifier(input_size=3)
injury_model.load_state_dict(torch.load('injury_model.pth', weights_only=True))
injury_model.eval()
injury_scaler = joblib.load('injury_scalar.pkl')  # rename accordingly

injury_labels = {0: "Low Risk", 1: "Medium Risk", 2: "High Risk"}

# -----------------


# Fatigue levels Model
fatigue_model = FatigueRegressor(input_size=3)
fatigue_model.load_state_dict(torch.load('fatigue_model.pth'))
fatigue_model.eval()
fatigue_scaler = joblib.load('fatigue_scalar.pkl')

# -------------------------
# Injury Prediction Endpoint
# -------------------------
@app.route('/predict-injury', methods=['POST'])
def predict_injury():
    data = request.json
    features = [
        data['Previous_Injuries'],
        data['Training_Intensity'],
        data['BMI']
    ]
    X_scaled = injury_scaler.transform([features])
    input_tensor = torch.tensor(X_scaled, dtype=torch.float32)

    with torch.no_grad():
        output = injury_model(input_tensor)
        prediction = torch.argmax(output, dim=1).item()

    return jsonify({
        'class': int(prediction),
        'label': injury_labels[prediction]
    })

# -------------------------
# Fatigue Prediction Endpoint
# -------------------------
@app.route('/predict-fatigue', methods=['POST'])
def predict_fatigue():
    data = request.json
    features = [
        data['Speed'],
        data['Strength'],
        data['Stamina']
    ]
    X_scaled = fatigue_scaler.transform([features])
    input_tensor = torch.tensor(X_scaled, dtype=torch.float32)

    with torch.no_grad():
        output = fatigue_model(input_tensor)
        fatigue_percent = float(output.item() * 100)

    return jsonify({
        'fatigue_percent': round(fatigue_percent, 2)
    })

# -------------------------
# Run the API
# -------------------------
if __name__ == '__main__':
    app.run(debug=True)
