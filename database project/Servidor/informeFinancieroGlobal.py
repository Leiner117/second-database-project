from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
informe = Blueprint('informe', __name__)

@informe.route('/informeFinanciero', methods=['GET'])
def obtener_datos_informe():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM VistaInformeFinancieroGlobal'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'FechaInicio':row.FechaInicio,'FechaFin':row.FechaFin,'ViajesTotales':row.ViajesTotales,'GastosTotales':row.GastosTotales,'PagosTotales':row.PagosTotales,'GananciaTotal':row.GananciaTotal} for row in rows]
        response = jsonify({'datos': datos})
        response.headers.add("Access-Control-Allow-Origin", "*")  # Permite solicitudes desde cualquier origen
        response.headers.add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")  # Métodos HTTP permitidos
        response.headers.add("Access-Control-Allow-Headers", "Content-Type, Authorization")  # Encabezados permitidos
        return response
        