import { useCallback } from 'react';

const useYupResolver = schema => {
    return useCallback(
        async (data) => {
            try {
                const values = await schema.validate(data, { abortEarly: false });
                return {
                    values,
                    errors: {},
                };
            } catch (errors) {
                return {
                    values: data,
                    errors: errors.inner.reduce(
                        (allErrors, currentError) => ({
                            ...allErrors,
                            [currentError.path]: {
                                type: currentError.type ?? "validation",
                                message: currentError.message
                            }
                        }),
                    {}
                    ),
                };
            }
        },
        [ schema ],
    );
};

export default useYupResolver;