function varargout= mi_pburg( x, orden, nfft, ventana, Fs)
%PBURGW   Estimaci�n Espectral de Potencia usando Burg enventanando la se�al
%   Pxx = PBURGW(x,Orden,nfft,Ventana) es la estimaci�n de la D.E.P.(Densidad
%	Espectral de Potencia) de la se�al x, usando el m�todo de Burg con 
%	enventanado. Orden es el orden del modelo Auto Regresivo de predicci�n lineal.
%	NFFT es la longitud de la FFT que determina las frecuencias a que se
%	estima la D.E.P. Ventana es el nombre de la funci�n Matlab que realiza
%	una determinada ventana, se introduce en comillas simples como texto Ej.: 'blackmanharris'. 
%	Pxx tendr� longitud (NFFT/2+1) para NFFT par, (NFFT+1)/2 para NFFT impar,
%	y NFFT si x es una se�al compleja. NFFT por defecto vale 256.
%	Si no se especifica la ventana, se utiliza por defecto la ventana
%	rectangular(rectwin). 
%
%   [Pxx,F] = PBURGW(x,Orden,nfft,Ventana,Fs) devuelve adem�s, el vector de
%	frecuencias en que se eval�a en la D.E.P., para una frecuencia de muestreo Fs.
%	Por defecto usa una Fs de 2 [Hz].
%
%   PBURGW sin argumentos de salida grafica la Densidad Espectral de Potencias.


%1 - Revisi�n de los par�metros de entrada
narginchk(2,5);
if isempty(orden)
   error('Necesita indicar el orden del modelo.');% Se tiene que especificar el orden del modelo
end
if nargin < 5, Fs = [];   end 
if nargin < 4, ventana='rectwin'; end % Ventana rectangular
if nargin < 3, nfft = []; end
if isempty(nfft), nfft = 256; end
if isempty(Fs), Fs = 2; end

%2 - Inicializaci�n de los par�metros
N  = length(x);
fi_t = x(2:end); % fragmento de vector de errores de predicci�n hacia adelante
gi_t = x(1:end-1); % fragmento de vector de errores de predicci�n hacia atr�s
a  = 1; % Inicializaci�n del vector de estimadores de los coeficientes (a_k) del filtro Auto Regresivo
	Epsilon = x*x'/N; % (Epsilon_0)(Error de m�n. cuadrados)
K = zeros(orden,1); % Estima de los coeficientes de reflexi�n

%3 - C�lculo de estimadores de K, E.
%-----Algoritmo Iterativo/
for i=1:orden
   % C�lculo de la ventana:
   % Se puede usar cualquier ventana que este implementada como una funci�n Matlab
   % Pero se recomienda utilizar la por defecto:
   vent = ['v=' ventana '(length(fi_t));'];
   eval(vent);
   v = v(:)'; % Conversion a vector fila(tanto si era columna como fila)
   K(i)=-((v.*fi_t)*gi_t')/(((v.*fi_t) * fi_t'  +  (v.*gi_t) * gi_t')/2);
   
   
   a = [a;0] + K(i) * [0;flipud(conj(a))]; % Actualizaci�n de los {ak}
   
   fi_t_nuevo = fi_t + K(i) * gi_t;
   gi_t_nuevo = K(i)' * fi_t + gi_t;
   fi_t = fi_t_nuevo(2:end);
   gi_t = gi_t_nuevo(1:end-1);
   
   Epsilon(i+1) = (1-K(i)*K(i)') * Epsilon(i); % Error de m�n. cuadrados
end 
% Fin del algoritmo Iterativo.

%4 - Estimaci�n de la DEP usando la FFT(periodograma)
Af = abs( fft( a, nfft ) ) .^ 2; % Funci�n de trasferencia del denominador del filtro
Pxx   = Epsilon(end) ./ Af; % Funci�n de trasferencia teniendo en cuenta la entrada(ruido)

%5 - Control de la salida
% Si la entrada es real, se selecciona s�lo la primera mitad
if isreal(x)
   select = (1:floor(nfft/2)+1)'; %Siempre es unilateral(Solo frecuencias positivas)
   Pxx = Pxx(select);
   %Para que sea unilateral hay que hacer una correcci�n
   Pxx(1)=Pxx(1)/2;
   Pxx(end)=Pxx(end)/2;
else
   select = (1:nfft)';
   Pxx = Pxx(select);
end

ff = (select - 1)*Fs/nfft;

%Argumentos de salida:
if nargout == 0
   newplot;
   plot(ff,10*log10(Pxx)); grid on;
   xlabel('Frecuencia [Hz]');
   ylabel('M�dulo de la Densidad Espectral de Potencia [dB]');
   title('Estimaci�n Espectral de Burg');
end
if nargout >= 1
   varargout{1} = Pxx;
end
if nargout >= 2
   varargout{2} = ff;
end

