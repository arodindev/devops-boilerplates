import './App.css';
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import TaskView
  from './components/TaskListView';

// Konstante um zwischen dev und prod zu wechseln
const devUrl = 'http://localhost:8000/api/task';
const url = '/api/task';

function App() {

  const [taskList, setTaskList] = useState([{}])
  const [title, setTitle] = useState('')
  const [description, setDesc] = useState('')

  // Update Tasks
  useEffect(() => {
    axios.get(url)
      .then(res => {
        setTaskList(res.data)
      })
  }, []);

  // Add Task
  const addTaskHandler = () => {
    axios.post(url, { 'title': title, 'description': description })
      .then(res => {
        console.log(res)
        console.log(res);
        const newTaskList = [...taskList];
        newTaskList.push(res.data);
        setTaskList(newTaskList);
      })
  };

  // Render Task cards
  return (
    <div className="App list-group-item justify-content-center 
    align-items-center mx-auto" style={{
        "width": "400px",
        "backgroundColor": "white", "marginTop": "15px"
      }}>
      <h1 className="card text-white bg-primary mb-1"
        stylename="max-width: 20rem;">Task manager</h1>
      <div className='card-body'>
        <span className='card-text'>
          <input className='mb-2 form-control titleIn' onChange={event => setTitle(event.target.value)} placeholder='Title' />
          <input className='mb-2 form-control desIn' onChange={event => setDesc(event.target.value)} placeholder='Description' />
          <button className='btn btn-outline-primary mx-2 mb-2' style={{ 'borderRadius': '50px', 'fontWeight': 'bold' }} onClick={addTaskHandler}> Add Task</button>
        </span>

        <div>
          <TaskView taskList={taskList} />
        </div>
      </div>
    </div>
  );
}

export default App;
