from flask import Flask

def create_app():
    # Initialiser l'application Flask
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'secret_key'

    # Importer et enregistrer les routes
    from .routes import main
    app.register_blueprint(main)

    return app
