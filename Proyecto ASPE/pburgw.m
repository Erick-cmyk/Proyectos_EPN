function varargout= pburgw( x, p, nfft, ventana, Fs)
%PBURGW   Estimación Espectral de Potencia usando Burg con enventanados
%   Pxx = PBURGW(x,ORDEN,NFFT,VENTANA) es la estimación de la D.E.P.(Densidad
%	 Espectral de Potencia) de la señal x, usando el método de Burg con 
%	 enventanado. ORDEN es el orden del modelo AR de predicción lineal.
%	 NFFT es la longitud de la FFT que determina las frecuencias a que se
%	 estima la D.E.P. VENTANA es el nombre de la función Matlab que realiza
%	 una determinada ventana, por ejemplo 'boxcar'(equivaldría al método de
%	 Burg básico), o 'hamming' empleado por Swingler. 
%	 Pxx tendrá longitud (NFFT/2+1) para NFFT par, (NFFT+1)/2 para NFFT impar,
%	 y NFFT si x es una señal compleja. NFFT es un parámetro opcional que por
%	 defecto vale 256.
%	 Si no se especifica la ventana, se sobrentiende que se usa la ventana
%	 rectangular(boxcar). 
%
%   [Pxx,F] = PBURGW(X,ORDER,NFFT,ventana,Fs) devuelve además, el vector de
%	 frecuencias en que se evalúa la D.E.P., para una frecuencia de muestreo Fs.
%	 Por defecto Fs vale 2Hz, que equivaldría a usar un vector de frecuencias
%	 normalizadas.
%
%   PBURGW sin argumentos de salida dibuja la DEP en la siguiente figura disponible.
%
%	 Puede usarse el parámetro NFFT por defecto, indicándolo como una matriz
%	 vacía [], ej. PBURGW(X,4,[],1000).




%1 - Revisión de los parámetros de entrada/Input Parameters Revision--------------------------------------->>
narginchk(2,5);
if isempty(p)
   error('Model order is needed.');%Necesita indicar el orden del modelo
end
if nargin < 5, Fs = [];   end
if nargin < 4, ventana='boxcar'; end %Ventana rectangular/Right-angled Window
if nargin < 3, nfft = []; end
if isempty(nfft), nfft = 256; end
if isempty(Fs), Fs = 2; end

%2 - Inicialización de los parámetros/Parameters Initialization-------------------------------------------->>
N  = length(x);
fi_t = x(2:end);%Vector truncado de errores de predicción hacia adelante/Forward prediction errors truncated vector
gi_t = x(1:end-1);%Vector truncado de errores de predicción hacia atrás/Backward prediction errors truncated vector
a  = 1;%Inicialización del vector de estimas de los coeficientes {ak} del filtro AR/ {ak}=AR filter coefficientes vector initialization
	Epsilon = x*x'/N; %(Epsilon0)(Error de mín. cuadrados)/(Min. square error)
K = zeros(p,1); %Estima de los coeficientes de reflexión/Reflection coefficients Estimate

%3 - Cálculo de las estimas de K, E, {ak}/ K, E {ak} Evaluation-------------------------------------------->>
%-----Procedimiento Iterativo/Iterative Algorithm---------------------------------------------------------->>
for i=1:p
   %Cálculo de la ventana/Window evaluation:
   %Haciéndolo como sigue, puedo usar cualquier ventana que este
   %implementada como una función Matlab:
   %Using this way, I can use whatever function I want, if it is built with Matlab:
   vent=['v=' ventana '(length(fi_t));'];
   eval(vent);
   v=v(:)'; %Para convertirlo a fila(tanto si era columna como fila)/Convert to row.

   K(i)=-((v.*fi_t)*gi_t')/(((v.*fi_t) * fi_t'  +  (v.*gi_t) * gi_t')/2);%Con ventana/Using window
   
   
   a = [a;0] + K(i) * [0;flipud(conj(a))]; %Actualización de los {ak} / {ak} Actualization
   
   fi_t_nuevo= 		  fi_t	+	K(i) * gi_t;
   gi_t_nuevo= K(i)' * fi_t  +			 gi_t;
   fi_t= fi_t_nuevo(2:end);
   gi_t= gi_t_nuevo(1:end-1);
   
   Epsilon(i+1) = (1-K(i)*K(i)')*Epsilon(i);%error de mín. cuadrados/min. square error
end
%-----------------------------<<------------Fin del procedimiento Iterativo/Iterative Algorithm ends here.

%4 - Estimación de la DEP usando la FFT(periodograma)/PSD Estimation using FFT(periodogram)---------------->>
Af = abs( fft( a, nfft ) ) .^ 2; %Función de trasferencia del denominador del filtro/Filter denominator Transfer Function
Pxx   = Epsilon(end) ./ Af; %Función de trasferencia teniendo en cuenta la entrada(ruido)/Transfer Function including noise

%5 - Control de la salida/Output Control------------------------------------------------------------------->>
%Si la entrada es real, se selecciona sólo la primera mitad/If entry is real, we get only first half:
if isreal(x)
   select = (1:floor(nfft/2)+1)';%Siempre es unilateral(Solo frecuencias positivas)/Always is onesided(only positive frequencies)
   Pxx = Pxx(select);
   %Para que sea unilateral hay que hacer una corrección/To be onesided, we must made a correction:
   Pxx(1)=Pxx(1)/2;
   Pxx(end)=Pxx(end)/2;
else
   select = (1:nfft)';
   Pxx = Pxx(select);
end

ff = (select - 1)*Fs/nfft;

%Argumentos de salida/Output arguments:
if nargout == 0
   newplot;
   plot(ff,10*log10(Pxx)); grid on;
   xlabel('Frequency');
   ylabel('Power Spectrum Magnitude (dB)');%(Módulo de la D.E.P.[dB])
   title('Burg Spectral Estimate');%(Estimación Espectral de Burg)
end
if nargout >= 1
   varargout{1} = Pxx;
end
if nargout >= 2
   varargout{2} = ff;
end




