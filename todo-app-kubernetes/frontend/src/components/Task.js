import axios from 'axios'
import React from 'react'

// Konstante um zwischen dev und prod zu wechseln
const devUrl = 'http://localhost:8000/api/task';
const url = '/api/task';

// Funktion um Task zu löschen. Es wird ein Button neben jeden Task gerendert
// TODO: Bug: Seite muss immer manuell refresht werden, damit taskList aktualisiert wird
function TaskItem(props) {
    const deleteTaskHandler = (title) => {
        axios.delete(`${url}/${title}`).then(res =>
            console.log(res.data))
    }
    return (
        <div>
            <p>
                <span style={{ fontWeight: 'bold, underline' }}>{props.task.title} : </span>
                {props.task.description}
                <button onClick={() => deleteTaskHandler(props.task.title)} className="btn btn-outline-danger my-2 mx-2" stlye={{ 'borderRadius': '50px', }}>X</button>
            </p>
        </div>
    )
}

export default TaskItem;