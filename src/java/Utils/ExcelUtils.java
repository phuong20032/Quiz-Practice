package Utils;

import jakarta.servlet.http.HttpSession;
import model.Question;
import model.Answer;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import static org.apache.poi.ss.usermodel.CellType.BLANK;
import static org.apache.poi.ss.usermodel.CellType.BOOLEAN;
import static org.apache.poi.ss.usermodel.CellType.FORMULA;
import static org.apache.poi.ss.usermodel.CellType.NUMERIC;
import static org.apache.poi.ss.usermodel.CellType.STRING;

public class ExcelUtils {

    public static List<Question> readQuestionsFromExcel(InputStream inputStream, HttpSession session) {
        
        List<Question> questions = new ArrayList<>();
        Set<String> questionSet = new HashSet<>(); 
        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();

            // Validate header
            if (!rowIterator.hasNext() || !validateHeader(rowIterator.next())) {
                session.setAttribute("notificationErr", "Invalid header row. Expected 'Question', 'Answer', 'Iscorrect'");
            return questions;
            }

            Question currentQuestion = null;

            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Cell questionCell = row.getCell(0);
                Cell answerCell = row.getCell(1);
                Cell isCorrectCell = row.getCell(2);

                

                String questionText = getCellValueAsString(questionCell);
                if (questionSet.contains(questionText)) {
                    session.setAttribute("notificationErr", 
                        "Duplicate question found"+ ": " + questionText);
                    continue;
                }

                // New question
                if (!questionText.isEmpty()) {
                    questionSet.add(questionText);
                    currentQuestion = new Question();
                    currentQuestion.setQuestion_name(questionText);
                    currentQuestion.setAnswers(new ArrayList<>());
                    questions.add(currentQuestion);
                }

                if (currentQuestion != null) {
                    // Add answer to the current question
                    Answer answer = new Answer();
                    answer.setAnswer_content(getCellValueAsString(answerCell));
                    answer.setIsCorrect(isCorrectCell != null && "yes".equalsIgnoreCase(getCellValueAsString(isCorrectCell)));
                    currentQuestion.getAnswers().add(answer);
                }
            }
        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error reading Excel file: " + e.getMessage());
            e.printStackTrace();
        }
        return questions;
    }

    private static boolean validateHeader(Row headerRow) {
        if (headerRow == null) return false;
        Cell questionHeader = headerRow.getCell(0);
        Cell answerHeader = headerRow.getCell(1);
        Cell isCorrectHeader = headerRow.getCell(2);
        return "Question".equalsIgnoreCase(getCellValueAsString(questionHeader)) &&
               "Answer".equalsIgnoreCase(getCellValueAsString(answerHeader)) &&
               "Iscorrect".equalsIgnoreCase(getCellValueAsString(isCorrectHeader));
    }

    private static String getCellValueAsString(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    return String.valueOf((int) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            case BLANK:
                return "";
            default:
                return cell.toString();
        }
    }
}
