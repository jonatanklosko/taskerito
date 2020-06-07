import React from 'react';
import { LinearProgress, Fade } from '@material-ui/core';

/* Waits 800ms before showing LinearProgress. */
const Loading = () => {
  return (
    <Fade in={true} style={{ transitionDelay: '800ms' }}>
      <LinearProgress />
    </Fade>
  );
};

export default Loading;
