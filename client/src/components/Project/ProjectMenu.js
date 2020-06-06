import React, { useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import { IconButton, Menu, MenuItem } from '@material-ui/core';
import MoreVertIcon from '@material-ui/icons/MoreVert';

function ProjectMenu({ projectId }) {
  const [anchorEl, setAnchorEl] = useState(null);

  function handleClick(event) {
    setAnchorEl(event.currentTarget);
  }

  function handleClose() {
    setAnchorEl(null);
  }

  return (
    <>
      <IconButton onClick={handleClick}>
        <MoreVertIcon />
      </IconButton>
      <Menu
        anchorEl={anchorEl}
        keepMounted
        open={!!anchorEl}
        onClose={handleClose}
      >
        <MenuItem component={RouterLink} to={`/projects/${projectId}/edit`}>
          Edit
        </MenuItem>
        <MenuItem
          component={RouterLink}
          to={`/projects/${projectId}/tasks/new`}
        >
          New task
        </MenuItem>
      </Menu>
    </>
  );
}

export default ProjectMenu;
