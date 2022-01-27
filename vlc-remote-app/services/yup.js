import * as yup from 'yup';

import { ipAddressRegex, portNumberRegex } from '../utils/regex';

export const computerSchema = yup.object().shape({
    name: yup.string().required('Required'),
    ipAddress: yup.string().required('Required').matches(ipAddressRegex, 'Invalid IP address'),
    vlcPortNumber: yup.string().required('Required').matches(portNumberRegex, 'Invalid port number'),
    password: yup.string().required('Required'),
    companionPortNumber: yup.string().matches(portNumberRegex, { message: 'Invalid port number', excludeEmptyString: true }),
    useByDefault: yup.boolean().required(),
});