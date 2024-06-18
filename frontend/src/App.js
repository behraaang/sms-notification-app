// frontend/src/App.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Container, TextField, Button, List, ListItem, ListItemText, ListItemSecondaryAction, IconButton, Typography } from '@mui/material';
import { CheckCircleOutline, CancelOutlined } from '@mui/icons-material';
import './App.css';

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState('');

  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    const response = await axios.get('/tasks');
    setTasks(response.data);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    await axios.post('/tasks', { task: { title, status: 'incomplete' } });
    setTitle('');
    fetchTasks();
  };

  const handleUpdateStatus = async (id, newStatus) => {
    await axios.put(`/tasks/${id}`, { task: { status: newStatus } });
    fetchTasks();
  };

  return (
    <Container maxWidth="sm">
      <Typography variant="h4" gutterBottom>
        Task List
      </Typography>
      <form onSubmit={handleSubmit} style={{ marginBottom: '2rem' }}>
        <TextField
          label="Task Title"
          variant="outlined"
          fullWidth
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          style={{ marginBottom: '1rem' }}
        />
        <Button type="submit" variant="contained" color="primary" fullWidth>
          Add Task
        </Button>
      </form>
      <List>
        {tasks.map((task) => (
          <ListItem key={task.id} divider>
            <ListItemText primary={task.title} secondary={`Status: ${task.status}`} />
            <ListItemSecondaryAction>
              <IconButton
                edge="end"
                aria-label="toggle status"
                onClick={() => handleUpdateStatus(task.id, task.status === 'completed' ? 'incomplete' : 'completed')}
              >
                {task.status === 'completed' ? <CancelOutlined color="error" /> : <CheckCircleOutline color="primary" />}
              </IconButton>
            </ListItemSecondaryAction>
          </ListItem>
        ))}
      </List>
    </Container>
  );
}

export default App;
