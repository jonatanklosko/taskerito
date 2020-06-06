import React from 'react';
import { Link as RouterLink } from 'react-router-dom';
import { List, ListItem, ListItemText } from '@material-ui/core';

function ProjectList({ projects }) {
  return (
    <List>
      {projects.map((project) => (
        <ListItem
          key={project.id}
          button
          component={RouterLink}
          to={`/projects/${project.id}`}
        >
          <ListItemText
            primary={project.name}
            secondary={project.description}
          />
        </ListItem>
      ))}
    </List>
  );
}

export default ProjectList;
