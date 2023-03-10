// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract TaskContract {
  event AddTask(address recipient, uint taskId)
  event DeleteTask(uint taskId, bool isDeleted)

  // this defines the structure of each task object
  // { id: 0, taskText: 'clean', isDeleted: false }
  struct Task {
    uint id;
    string taskText;
    bool isDeleted;
  }

  // create an array that holds the task objects
  Task[] private tasks;
  // associates unique key for each task to a user address
  // e.g. ----> {0: '0xsteve...7a'}, {1: '0xnikki...7a'}
  mapping(uint256 => address) taskToOwner;

  // add tasks
  function addTask(string memory taskText, bool isDeleted) external {
    // set the task id
    uint taskId = tasks.length;
    // append task to array
    tasks.push(Task(taskId, taskText, isDeleted));
    taskToOwner[taskId] = msg.sender; // gets wallet address of logged in user
    emit AddTask(msg.sender, taskId);
  }

  // get tasks for logged in user that are not deleted
  function getMyTasks() external view returns (Task[] memory) {
    // create temporary array
    Task[] memory temporary = new Task[](tasks.length);
    uint counter = 0;

    // loop through Tasks and add to 'temporary'
    // if tasks is for logged in user and task is not deleted
    for (unit i = 0; i < tasks.length; i++) {
      if (taskToOwner[i] == msg.sender && tasks[i].isDeleted == false) {
        temporary[counter] = tasks[i]; // common way to 'push' in Solidity
        counter++;
      }
    }
    Task[] memory result = new Task[](counter);

    for (uint i = 0; i < counter; i++) {
      result[i] = temporary[i];
    }

    return result;
  }

  // delete tasks
  function deleteTask(uint taskId, bool isDeleted) external {
    if (taskToOwner[taskId] == msg.sender) {
      tasks[taskId].isDeleted = isDeleted;
      emit DeleteTask(task, isDeleted);
    }
  }
}
