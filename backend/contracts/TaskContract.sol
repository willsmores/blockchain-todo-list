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

  function addTask(string memory taskText, bool isDeleted) external {
    // set the task id
    uint taskId = tasks.length;
    // append task to array
    tasks.push(Task(taskId, taskText, isDeleted));
    taskToOwner[taskId] = msg.sender; // gets wallet address of logged in user
    emit AddTask(msg.sender, taskId)
  }

  // get tasks for logged in user that are not deleted
  function getMyTasks() external view returns (Task[] memory) {
    temporary = new Task[](tasks.length);
  }
}
