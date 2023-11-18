import TaskItem from "./Task";

// rendert Task view
function TaskView(props) {
    return (
        <div>
            <ul>
                {props.taskList.map(task => <TaskItem task={task} />)}
            </ul>
        </div>
    )
}

export default TaskView