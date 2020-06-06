import React from 'react';
import { useHistory } from 'react-router-dom';
import { useMutation, gql } from '@apollo/client';
import SignUpForm from './SignUpForm';
import welcome from './welcome.svg';
import { optionalGet } from '../../lib/utils';
import { storeToken } from '../../lib/auth';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';

const SIGN_UP = gql`
  mutation SignUp($input: SignUpInput!) {
    signUp(input: $input) {
      successful
      messages {
        field
        message
        code
      }
      result {
        token
      }
    }
  }
`;

function SignUp() {
  const history = useHistory();
  const [signUp, { data, loading }] = useMutation(SIGN_UP, {
    onCompleted: ({ signUp: { successful, result } }) => {
      if (successful) {
        storeToken(result.token);
        history.push('/');
      }
    },
  });

  return (
    <CenteredFormContainer svgImage={welcome} title="Sign up">
      <SignUpForm
        disabled={loading}
        validationErrors={optionalGet(data, 'signUp.messages')}
        onSubmit={(data) => signUp({ variables: { input: data } })}
      />
    </CenteredFormContainer>
  );
}

export default SignUp;
