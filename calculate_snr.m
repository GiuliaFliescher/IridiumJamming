function SNR_dB = calculate_snr(iq_data)
    load(iq_data);
    iq_data=jamming;
    % Extract I and Q components
    I = iq_data(1:2:end); % First column is I
    Q = iq_data(2:2:end); % Second column is Q
    
    % Compute received signal power (P_rx) in dBm
    P_rx_dBm = 30 + 10 * log10(I.^2 + Q.^2);
    
    % Compute the amplitude of the received signal
    amplitude = sqrt(I.^2 + Q.^2);
    
    % Define the window size for noise estimation
    window_size = 10;
    num_samples = length(amplitude);
    
    % Initialize noise power array
    N_dBm = zeros(num_samples - window_size + 1, 1);
    
    % Start a parallel pool (if not already started)
    if isempty(gcp('nocreate'))
        parpool; % Start parallel pool if not already running
    end

    % Compute noise power using parallel processing
    parfor n = 1:(num_samples - window_size + 1)
        window_samples = amplitude(n:n + window_size - 1);
        mu = mean(window_samples); % Mean over the window
        noise_variance = mean((window_samples - mu).^2); % Variance
        N_dBm(n) = 30 + 10 * log10(noise_variance);
    end
    
    % Align P_rx_dBm with noise power calculations
    P_rx_dBm = P_rx_dBm(window_size:end);
    
    % Compute SNR in dB
    SNR_dB = P_rx_dBm - N_dBm;
    
    % Display result
    %pfigure
    %histogram(SNR_dB)
end
